select customer_id, count(*) as count_no_trans
from visits v
left join transactions t
on v.visit_id = t.visit_id
where transaction_id is null
group by customer_id

def find_customers(visits: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    df = visits.merge(
        transactions,
        how="left",
        on=["visit_id"]
    )
    df = df.loc[df["transaction_id"].isnull()][["customer_id"]].reset_index(drop=True)
    df = df.groupby(["customer_id"], as_index=False).size().rename(columns={"size": "count_no_trans"})
    return df

    -- method 2
    df = visits.merge(
        transactions,
        how="left",
        on=["visit_id"]
    )
    df = df.loc[df["transaction_id"].isnull(), [["customer_id"]]]
    df = df.groupby(["customer_id"], as_index=False).size().rename(columns={"size": "count_no_trans"})
    return df

    -- method 3
    df = visits.merge(
        transactions,
        how="left",
        on=["visit_id"]
    )
    df = df[df["transaction_id"].isnull()].groupby(["customer_id"], as_index=False).agg(count_no_trans=("visit_id", "nunique"))
    return df
