import pool from "@/app/lib/db";
import {auth} from "@/auth";

export async function GET() {
    const session = await auth();
    if (!session?.user?.id) {
        return Response.json(
            { error: "Unauthorized" },
            { status: 401 }
        );
    }

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