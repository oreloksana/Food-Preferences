Before running the jupiter notebook create .env file in the root directory of the project and add the following lines to it:
Replace the values of host, db_name, user, and password with your actual database credentials.

PGHOST=host
PGPORT=5432
PGDATABASE=db_name
PGUSER=user
PGPASSWORD=password

create a virtual environment and install the required dependencies by running the following commands in your terminal:

```bash
python -m venv venv
source venv/bin/activate  # On Windows use `venv\Scripts\activate`
pip install -r requirements.txt 
