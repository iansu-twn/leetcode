select
    name, population, area
from world
where area >= 3000000
and population >= 25000000

def big_countries(world: pd.DataFrame) -> pd.DataFrame:
    -- method 1
    res = world.query(
        "area >= 3000000 or population >= 25000000"
    )[["name", "population", "area"]]
    return res

    -- method 2
    res = world.loc[
        lambda row:
            (row["area"] >= 3000000) |
            (row["population"] >= 25000000)
    ][["name", "population", "area"]]
    return res

    -- method 3
    res = world[
        (world.area >= 3000000) |
        (world.population >= 25000000)
    ][["name", "population", "area"]]
    return res