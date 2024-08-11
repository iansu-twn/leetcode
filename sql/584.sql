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