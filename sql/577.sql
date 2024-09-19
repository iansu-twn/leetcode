select name, bonus
from employee e
left join bonus b
on e.empid = b.empid
where bonus is null or bonus < 1000

def employee_bonus(employee: pd.DataFrame, bonus: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    df = employee.merge(
        bonus,
        how="left",
        on=["empId"]
    )
    df = df[
        (df["bonus"].isnull()) |
        (df["bonus"] < 1000)
    ]
    return df[["name", "bonus"]]

    -- method 2
    return (
        employee.merge(
            bonus,
            how="left",
            on=["empId"]
        ).loc[
            lambda row: (row["bonus"].isnull()) |
            (row["bonus"] < 1000)
        ][["name", "bonus"]]
    )
