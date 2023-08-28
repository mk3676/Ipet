
from database import Database
import pandas as pd

db_class = Database()

df = pd.read_csv('pet_hos.csv',encoding='cp949')

print(df)

for i in df.values:
    db_class.execute("insert into pethospital values(null,'"+str(i[0])+"','"+i[1]+"')")
    db_class.commit()

# query="insert into pethospital values(null,"
# db_class.executeAll()
