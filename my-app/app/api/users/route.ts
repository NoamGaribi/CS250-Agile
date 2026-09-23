import pool from "@/app/lib/db";

export async function GET() {
    try {
        const [users] = await pool.query(
            "SELECT * FROM user");

        return Response.json(users);
    } catch (error) {
        console.error(error);

        return Response.json(
            { error: "Database error" },
            { status: 500 }
        );
    }
}