select name
from customer
where referee_id != 2
or referee_id is null

def find_customer_referee(customer: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    res = customer.loc[
        lambda row:
            (row["referee_id"].isna()) |
            (row["referee_id"] != 2)
    ][["name"]]
    return res

    -- method 2
    res = customer[
        (customer["referee_id"].isna()) |
        (customer["referee_id"] != 2)
    ][["name"]]
    return res

    -- method 3
    customer["referee_id"] = customer["referee_id"].fillna(0)
    res = customer.query("referee_id != 2")
    return res[["name"]]