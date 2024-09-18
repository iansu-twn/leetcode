select unique_id, name
from employees e
left join employeeuni eu
on e.id = eu.id

def replace_employee_id(employees: pd.DataFrame, employee_uni: pd.DataFrame) -> pd.DataFrame:
    df = employees.merge(
        employee_uni,
        how="left",
        on=["id"]
    )[["unique_id", "name"]]
    return df
