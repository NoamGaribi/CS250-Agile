import pool from "@/app/lib/db";
import { DegreeAudit } from "@/app/lib/DegreeAudit";

import type {
  ResultSetHeader,
  RowDataPacket
} from "mysql2";


interface RequirementRow extends RowDataPacket {
  id: number;
  requirement_name: string;
}


interface CourseRow extends RowDataPacket {
  id: number;
  course_code: string;
}

// GETS ALL REQUIREMENTS FOR A DEGREE
export async function getRequirementNamesForDegree(
  degreeId: number
): Promise<string[]> {

  const [rows] = await pool.query<RequirementRow[]>(
    `
    SELECT
      id,
      requirement_name

    FROM degree_requirements

    WHERE degree_id = ?

    ORDER BY requirement_name
    `,
    [degreeId]
  );

  return rows.map(
    (row) => row.requirement_name
  );
}


/**
 * Parses and saves a student's degree audit.
 *
 * The new audit starts as pending_review so the student
 * can confirm the extracted information before it is used
 * as confirmed academic data.
 */

// Saves a student's degree audit to the database
// Returns the ID of the new audit import
export async function saveDegreeAudit(
  userId: number,
  degreeId: number,
  audit: DegreeAudit,
  auditDate: string | null = null
): Promise<number> {

  const connection =
    await pool.getConnection();

  try {
    await connection.beginTransaction();


    // -------------------------------------------------
    // GET DEGREES REQUIREMENTS FROM DATABASE
    // -------------------------------------------------

    const [requirementRows] =
      await connection.query<RequirementRow[]>(
        `
        SELECT
          id,
          requirement_name

        FROM degree_requirements

        WHERE degree_id = ?
        `,
        [degreeId]
      );


    const requirementNames =
      requirementRows.map(
        (row) => row.requirement_name
      );


    // -------------------------------------------------
    // PARSE AUDIT
    // -------------------------------------------------

    audit.extractRequirements(
      requirementNames
    );

    audit.extractProgress();


    // -------------------------------------------------
    // CREATES AUDIT IMPORT RECORD
    // -------------------------------------------------

    const [auditResult] =
      await connection.query<ResultSetHeader>(
        `
        INSERT INTO audit_imports
        (
          user_id,
          audit_date,
          status
        )

        VALUES (?, ?, 'pending_review')
        `,
        [
          userId,
          auditDate
        ]
      );


    const auditImportId =
      auditResult.insertId;


    // -------------------------------------------------
    // SAVE COURSES FOUND IN THE AUDIT
    // -------------------------------------------------

    for (
      const parsedCourse
      of audit.getParsedCourses()
    ) {

      const [courseRows] =
        await connection.query<CourseRow[]>(
          `
          SELECT
            id,
            course_code

          FROM courses

          WHERE course_code = ?

          LIMIT 1
          `,
          [parsedCourse.courseCode]
        );

      // COURSE_ID CAN BE NULL IF THE COURSE IS NOT IN THE CATALOG.
      const courseId =
        courseRows.length > 0
          ? courseRows[0].id
          : null;


      await connection.query<ResultSetHeader>(
        `
        INSERT INTO user_courses
        (
          user_id,
          course_code,
          status,
          course_id,
          audit_import_id
        )

        VALUES (?, ?, ?, ?, ?)
        `,
        [
          userId,
          parsedCourse.courseCode,
          parsedCourse.status,
          courseId,
          auditImportId
        ]
      );
    }


    // -------------------------------------------------
    // SAVE REQUIREMENTS RESULTS FOUND IN THE AUDIT
    // -------------------------------------------------

    for (
      const parsedRequirement
      of audit.getParsedRequirements()
    ) {

      const requirement =
        requirementRows.find(
          (row) =>
            row.requirement_name ===
            parsedRequirement.name
        );


      const requirementId =
        requirement?.id ?? null;


      await connection.query<ResultSetHeader>(
        `
        INSERT INTO audit_requirement_results
        (
          audit_import_id,
          requirement_id,
          audit_requirement_name,
          status
        )

        VALUES (?, ?, ?, ?)
        `,
        [
          auditImportId,
          requirementId,
          parsedRequirement.name,
          parsedRequirement.status
        ]
      );
    }


    await connection.commit();

    return auditImportId;

  } catch (error) {

    await connection.rollback();

    throw error;

  } finally {

    connection.release();
  }
}