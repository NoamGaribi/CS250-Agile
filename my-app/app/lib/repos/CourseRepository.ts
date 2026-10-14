import pool from "@/app/lib/db";
import type { RowDataPacket } from "mysql2";


export interface CourseSummary {
  id: number;
  courseCode: string;
  courseName: string;
  units: number;
}


export interface CourseSection {
  sectionId: number;
  courseId: number;
  courseCode: string;
  courseName: string;
  units: number;

  termName: string;
  sectionNumber: string;

  instructionMode:
    | "in_person"
    | "online"
    | "hybrid"
    | "unknown";

  scheduleStatus:
    | "scheduled"
    | "asynchronous"
    | "unknown";

  instructorName: string | null;
}


export interface CourseMeeting {
  dayOfWeek: number;
  startTime: string;
  endTime: string;
  meetingType: string;
}

// RETURN EVERY COURSE STORED IN THE CATALOG
export async function getAllCourses(): Promise<CourseSummary[]> {
  const [rows] = await pool.query<RowDataPacket[]>(`
    SELECT
      id,
      course_code,
      course_name,
      units
    FROM courses
    ORDER BY course_code
  `);

  return rows.map((row) => ({
    id: row.id,
    courseCode: row.course_code,
    courseName: row.course_name,
    units: row.units,
  }));
}

// RETURN COURSES OFFERED IN A TERM
// ex: getCoursesOfferedInTerm("Spring 2027")
export async function getCoursesOfferedInTerm(
  termName: string
): Promise<CourseSummary[]> {

  const [rows] = await pool.query<RowDataPacket[]>(
    `
    SELECT DISTINCT
      c.id,
      c.course_code,
      c.course_name,
      c.units

    FROM courses c

    JOIN course_sections cs
      ON cs.course_id = c.id

    JOIN terms t
      ON t.id = cs.term_id

    WHERE t.term_name = ?

    ORDER BY c.course_code
    `,
    [termName]
  );

  return rows.map((row) => ({
    id: row.id,
    courseCode: row.course_code,
    courseName: row.course_name,
    units: row.units,
  }));
}

// RETURN COURSE SECTIONS FOR A COURSE IN A TERM
export async function getCourseSections(
  courseCode: string,
  termName: string
): Promise<CourseSection[]> {

  const [rows] = await pool.query<RowDataPacket[]>(
    `
    SELECT
      cs.id AS section_id,
      c.id AS course_id,
      c.course_code,
      c.course_name,
      c.units,

      t.term_name,
      cs.section_number,
      cs.instruction_mode,
      cs.schedule_status,

      i.instructor_name

    FROM courses c

    JOIN course_sections cs
      ON cs.course_id = c.id

    JOIN terms t
      ON t.id = cs.term_id

    LEFT JOIN section_instructors si
      ON si.section_id = cs.id

    LEFT JOIN instructors i
      ON i.id = si.instructor_id

    WHERE c.course_code = ?
      AND t.term_name = ?

    ORDER BY cs.section_number
    `,
    [courseCode, termName]
  );

  return rows.map((row) => ({
    sectionId: row.section_id,
    courseId: row.course_id,
    courseCode: row.course_code,
    courseName: row.course_name,
    units: row.units,

    termName: row.term_name,
    sectionNumber: row.section_number,

    instructionMode: row.instruction_mode,
    scheduleStatus: row.schedule_status,

    instructorName: row.instructor_name ?? null,
  }));
}

// RETURN MEETING TIMES FOR SECTION OF COURSE
export async function getSectionMeetings(
  sectionId: number
): Promise<CourseMeeting[]> {

  const [rows] = await pool.query<RowDataPacket[]>(
    `
    SELECT
      day_of_week,
      start_time,
      end_time,
      meeting_type

    FROM section_meetings

    WHERE section_id = ?

    ORDER BY
      day_of_week,
      start_time
    `,
    [sectionId]
  );

  return rows.map((row) => ({
    dayOfWeek: row.day_of_week,
    startTime: row.start_time,
    endTime: row.end_time,
    meetingType: row.meeting_type,
  }));
}


// RETURN PREREQUISITES FOR A COURSE
export async function getPrerequisitesForCourse(
  courseCode: string
): Promise<string[]> {

  const [rows] = await pool.query<RowDataPacket[]>(
    `
    SELECT
      prerequisite.course_code

    FROM course_prerequisites cp

    JOIN courses course
      ON course.id = cp.course_id

    JOIN courses prerequisite
      ON prerequisite.id = cp.prerequisite_course_id

    WHERE course.course_code = ?

    ORDER BY prerequisite.course_code
    `,
    [courseCode]
  );

  return rows.map((row) => row.course_code);
}


// RETURN DEGREE REQUIREMENTS THAT A COURSE CAN SATISFY
export async function getRequirementsForCourse(
  courseCode: string
): Promise<string[]> {

  const [rows] = await pool.query<RowDataPacket[]>(
    `
    SELECT
      dr.requirement_name

    FROM requirement_courses rc

    JOIN courses c
      ON c.id = rc.course_id

    JOIN degree_requirements dr
      ON dr.id = rc.requirement_id

    WHERE c.course_code = ?

    ORDER BY dr.requirement_name
    `,
    [courseCode]
  );

  return rows.map((row) => row.requirement_name);
}


/**
 * Return all courses mapped to one degree requirement.
 *
 * Example:
 * getCoursesForRequirement(
 *   "UD 3 Explorations - Arts and Humanities"
 * )
 */
export async function getCoursesForRequirement(
  requirementName: string
): Promise<CourseSummary[]> {

  const [rows] = await pool.query<RowDataPacket[]>(
    `
    SELECT
      c.id,
      c.course_code,
      c.course_name,
      c.units

    FROM requirement_courses rc

    JOIN degree_requirements dr
      ON dr.id = rc.requirement_id

    JOIN courses c
      ON c.id = rc.course_id

    WHERE dr.requirement_name = ?

    ORDER BY c.course_code
    `,
    [requirementName]
  );

  return rows.map((row) => ({
    id: row.id,
    courseCode: row.course_code,
    courseName: row.course_name,
    units: row.units,
  }));
}