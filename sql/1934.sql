select s.user_id, round(sum(case when c.action = 'confirmed' then 1 else 0 end)/count(*), 2) as confirmation_rate
from signups s
left join confirmations c
on s.user_id = c.user_id
group by s.user_id

select s.user_id, round(avg(if(c.action="confirmed", 1, 0)), 2) as confirmation_rate
from signups s
left join confirmations c
on s.user_id = c.user_id
group by s.user_id


def confirmation_rate(signups: pd.DataFrame, confirmations: pd.DataFrame) -> pd.DataFrame:
    df = signups.merge(
        confirmations,
        how="left",
        on=["user_id"]
    )
    df["confirmation_rate"] = df["action"].apply(
        lambda row: 1 if row == "confirmed" else 0
    )
    -- method 1
    return df.groupby(["user_id"])["confirmation_rate"].mean().round(2).reset_index()

    -- method 2
    return df.groupby(["user_id"]).agg(
        {"confirmation_rate": "mean"}
    ).round(2).reset_index()
