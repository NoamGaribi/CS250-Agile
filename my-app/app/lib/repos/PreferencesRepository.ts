import pool from "@/app/lib/db";
import { PlanningPreferences } from "@/app/lib/PlanningPreferences";
import type {
  RowDataPacket,
  ResultSetHeader
} from "mysql2";

interface PreferenceRow extends RowDataPacket {
  user_id: number;
  preferred_start_time: string | null;
  preferred_end_time: string | null;
  preferred_days: string | null;
  credits_per_semester: number | null;
  elective_interests: string | null;
}

// LOADS SAVED PLANNING PREFERENCES FOR A USER
// NULL IF NOT CREATED YET
export async function getPreferences(
  userId: number
): Promise<PlanningPreferences | null> {

  const [rows] = await pool.query<PreferenceRow[]>(
    `
    SELECT
      user_id,
      preferred_start_time,
      preferred_end_time,
      preferred_days,
      credits_per_semester,
      elective_interests

    FROM user_preferences

    WHERE user_id = ?

    LIMIT 1
    `,
    [userId]
  );

  if (rows.length === 0) {
    return null;
  }

  const row = rows[0];

  return new PlanningPreferences(
    row.credits_per_semester ?? 12,
    row.elective_interests ?? "",
    row.preferred_days ?? ""
  );
}

// CREATE/UPDATE PLANNING PREFERENCES FOR A USER
export async function savePreferences(
  userId: number,
  creditsPerSemester: number,
  electiveInterests: string,
  preferredDays: string,
  preferredStartTime: string | null = null,
  preferredEndTime: string | null = null
): Promise<void> {

  await pool.query<ResultSetHeader>(
    `
    INSERT INTO user_preferences
    (
      user_id,
      preferred_start_time,
      preferred_end_time,
      preferred_days,
      credits_per_semester,
      elective_interests
    )

    VALUES (?, ?, ?, ?, ?, ?)

    ON DUPLICATE KEY UPDATE
      preferred_start_time =
        VALUES(preferred_start_time),

      preferred_end_time =
        VALUES(preferred_end_time),

      preferred_days =
        VALUES(preferred_days),

      credits_per_semester =
        VALUES(credits_per_semester),

      elective_interests =
        VALUES(elective_interests)
    `,
    [
      userId,
      preferredStartTime,
      preferredEndTime,
      preferredDays,
      creditsPerSemester,
      electiveInterests
    ]
  );
}