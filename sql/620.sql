select *
from cinema
where mod(id, 2) = 1
and (description is null or description != 'boring')
order by rating desc

select * from cinema
where id % 2 = 1
and (description is null or description != 'boring')
order by rating desc

def not_boring_movies(cinema: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    return cinema[
        (cinema["id"] % 2 == 1) &
        (cinema["description"] != "boring")
    ].sort_values(["rating"], ascending=False)

    -- method 2
    return cinema.loc[
        lambda row: (row["id"] % 2 == 1) &
        (row["description"] != "boring")
    ].sort_values(["rating"], ascending=False)
