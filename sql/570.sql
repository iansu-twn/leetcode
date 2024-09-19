select name from employee e
where id in (
    select managerId from employee
    group by managerId
    having count(*) >= 5
)

select e.name
from employee e
left join employee e2
on e.id = e2.managerId
group by e.id
having count(*) >= 5

def find_managers(employee: pd.DataFrame) -> pd.DataFrame:
    df = employee.merge(
        employee,
        how="left",
        left_on=["id"],
        right_on=["managerId"],
        suffixes=("_a", "_b")
    )
    df = df.groupby(["id_a", "name_a"], dropna=False).size().rename("size").reset_index()
    df = df[
        df["size"] >= 5
    ]
    return df[["name_a"]].rename(columns={"name_a": "name"})
