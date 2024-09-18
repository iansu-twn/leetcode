select distinct author_id as id
from views
where author_id = viewer_id
order by id

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    df = views.loc[views["author_id"] == views["viewer_id"]][["author_id"]]
    df.rename(columns={"author_id": "id"}, inplace=True)
    return df[["id"]].drop_duplicates().sort_values("id")

    -- method 2
    df = views.loc[lambda row: row["author_id"] == row["viewer_id"]][["author_id"]]
    df.rename(columns={"author_id": "id"}, inplace=True)
    return df[["id"]].drop_duplicates().sort_values("id")

    -- method 3
    return (
        views[views["author_id"] == views["viewer_id"]]
        .loc[:, ["author_id"]]
        .rename(columns={"author_id": "id"})
        .drop_duplicates()
        .sort_values("id")
    )
