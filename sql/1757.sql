select product_id
from products
where low_fats = 'y'
and recyclable = 'y'

def find_products(
    product: pd.DataFrame
) -> pd.DataFrame:
    products = products.loc[
        lambda row:
            (row["low_fats"] == 'Y') &
            (row["recyclable"] == 'Y')
    ][["product_id"]]
    return products