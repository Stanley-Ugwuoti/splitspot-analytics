Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

### How to Install and use
First you clone this project by running 
```
git clone https://github.com/splitspot/splitspot-analytics.git && cd splitspot-analytics
```

This is a python project whose dependencies are managed with poetry so you will first need to start by installing python (3.8) and then install poetry.
```
pip3 install poetry
```

Then you need to setup the dbt profile which is basically what the dbt refers to when it wants to run the entire queries with dbt run

on new cmd run 
```
 cd $HOME && touch .dbt/profiles.yml && nano .dbt/profiles.yml
```
Then paste the contents of profiles.example.yml file into the newly created .dbt/profiles.yml

To install all the packages dependencies run `poetry install` which wil also create/activate a virtual environment to use for the project.

After installing dependencies you will need to authenticate gcloud so you can connect to the bigquery database

```
poetry run gcloud auth application-default login
```
A window will open in the browser where you'll login and copy a code sent to you and paste in the commandline.

To run any of the DBT commands you must prefix with `poetry run` like the folloing:
```
poetry run dbt run
```

or you can run `poetry shell` which will activate the virtual environment and prevent the need to prepend the commands with `poetry run`.

## Troubleshooting

If you get ERROR: gcloud failed to load: No module named '_sqlite3' because you use python with asdf try running
```
export CLOUDSDK_PYTHON=/usr/bin/python3
```