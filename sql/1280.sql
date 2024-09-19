select s.student_id, s.student_name, su.subject_name, count(e.subject_name) as attended_exams
from students s
cross join subjects su
left join examinations e
on s.student_id = e.student_id
and su.subject_name = e.subject_name
group by s.student_id, s.student_name, su.subject_name
order by s.student_id, su.subject_name

select s.student_id, s.student_name, su.subject_name, coalesce(e.attended_exams, 0) as attended_exams
from students s
cross join subjects su
left join (
    select student_id, subject_name, count(*) as attended_exams
    from examinations
    group by student_id, subject_name
)e on s.student_id = e.student_id and su.subject_name = e.subject_name
order by s.student_id, su.subject_name

def students_and_examinations(students: pd.DataFrame, subjects: pd.DataFrame, examinations: pd.DataFrame) -> pd.DataFrame:
    df = students.merge(
        subjects,
        how="cross",
    )
    test = examinations.groupby(["student_id", "subject_name"]).agg(
        attended_exams=("subject_name", "count")
    ).reset_index()
    df = df.merge(
        test,
        how="left",
        on=["student_id", "subject_name"]
    ).fillna({"attended_exams": 0})
    return df[["student_id", "student_name", "subject_name", "attended_exams"]].sort_values(["student_id", "subject_name"])
