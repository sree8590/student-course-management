
import mysql.connector
from mysql.connector import Error


try:
  
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="(qazsedc0987?)",
        database="institute_db"
    )

    if connection.is_connected():
        print("Connected to MySQL successfully!")

        cursor = connection.cursor()

        
        print("\nEnter Student Details")

        name = input("Enter student name: ")
        email = input("Enter email: ")
        city = input("Enter city: ")

        sql = """
            INSERT INTO Students (name, email, city)
            VALUES (%s, %s, %s)
        """

        values = (name, email, city)

        cursor.execute(sql, values)
        connection.commit()

        print("\nStudent inserted successfully!")

        print("\n--- All Students ---")

        cursor.execute("SELECT * FROM Students")
        students = cursor.fetchall()

        for student in students:
            print(student)

       
        print("\n--- Student Course Details ---")

        join_query = """
            SELECT s.name, c.course_name, e.marks
            FROM Students s
            INNER JOIN Enrollments e
                ON s.student_id = e.student_id
            INNER JOIN Courses c
                ON e.course_id = c.course_id
        """

        cursor.execute(join_query)
        records = cursor.fetchall()

        for record in records:
            print(
                "Student:", record[0],
                "| Course:", record[1],
                "| Marks:", record[2]
            )

except Error as e:
    print("Database error:", e)

    if 'connection' in locals() and connection.is_connected():
        connection.rollback()

except Exception as e:
    print("Error:", e)

finally:

    if 'cursor' in locals():
        cursor.close()

    if 'connection' in locals() and connection.is_connected():
        connection.close()
        print("\nDatabase connection closed.")
