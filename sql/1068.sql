select product_name, year, price
from sales s
join product p
on s.product_id = p.product_id

def sales_analysis(sales: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    df = sales.merge(
        product,
        how="inner",
        on=["product_id"]
    )
    return df[["product_name", "year", "price"]]
