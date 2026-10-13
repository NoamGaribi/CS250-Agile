import pool from "@/app/lib/db";
import { DegreeProgress } from "@/app/lib/DegreeProgress";
import type { RowDataPacket } from "mysql2";

interface CourseRow extends RowDataPacket {
  course_code: string;
}

interface RequirementRow extends RowDataPacket {
  requirement_name: string;
}



// LOADS STUDENT ACADEMIC PROGRESS STORED IN DATABASE
export async function getDegreeProgress(
  userId: number
): Promise<DegreeProgress> {

  // ---------------------------------------------
  // COMPLETED COURSES
  // ---------------------------------------------
  const [completedRows] = await pool.query<CourseRow[]>(
    `
    SELECT DISTINCT
      course_code
    FROM user_courses
    WHERE user_id = ?
      AND LOWER(status) IN (
        'completed',
        'complete'
      )
    ORDER BY course_code
    `,
    [userId]
  );

  const completedCourseCodes =
    completedRows.map((row) => row.course_code);


  // ---------------------------------------------
  // REMAINING DEGREE REQUIREMENTS
  //
  // USE STUDENTS MOST RECENT AUDIT IMPORT TO DETERMINE
  // ---------------------------------------------
  const [requirementRows] =
    await pool.query<RequirementRow[]>(
      `
       SELECT DISTINCT
        dr.requirement_name

       FROM audit_requirement_results arr

       JOIN degree_requirements dr
        ON dr.id = arr.requirement_id

       JOIN audit_imports ai
        ON ai.id = arr.audit_import_id

       WHERE ai.user_id = ?

        AND ai.id = (
            SELECT ai2.id
            FROM audit_imports ai2
            WHERE ai2.user_id = ?
            AND ai2.status = 'confirmed'
            ORDER BY ai2.imported_at DESC
            LIMIT 1
        )

        AND (
         arr.status IN ('not_satisfied', 'in_progress')
         OR COALESCE(arr.remaining_units, 0) > 0
         OR COALESCE(arr.remaining_course_count, 0) > 0
        )

      ORDER BY dr.requirement_name
      `,
      [userId, userId]
    );

  const remainingRequirements =
    requirementRows.map(
      (row) => row.requirement_name
    );


  return new DegreeProgress(
    completedCourseCodes,
    remainingRequirements
  );
}