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
Make sure you have python installed on your system, if you don't, download and install python 3.6 and above if you're on windows,
on linux or mac python comes preinstalled.

First you clone this project by running 
```
git clone https://github.com/splitspot/splitspot-analytics.git && cd splitspot-analytics
```

Then you run 
```
pip3 install --user --upgrade dbt-bigquery
```

Your dbt is in ``` ~/.local/bin/dbt ``` which you can add to path in your .bashrc in mac/linux if you wish to.
On windows follow this tutorial [here](https://www.dataduel.co/install-dbt-on-win10-april-2021/)

Then you need to setup the dbt profile which is basically what the dbt refers to when it wants to run the entire queries with dbt run

on new cmd run 
```
 cd $HOME && touch .dbt/profile.yml && nano .dbt/profile.yml
```
Then paste the contents of profile.example.yml file into the newly created .dbt/profile.yml

Then install gcloud following the instructions here https://cloud.google.com/sdk/docs/install

Then run
```
gcloud auth application-default login
```
A window will open in the browser where you'll login and copy a code sent to you and paste in the commandline.

Now you can run
```
~/.local/bin/dbt run
```

or if you have dbt in path you run
```
dbt run
```

## Troubleshooting


If you get an error like /usr/local/bin/python3.7: bad interpreter: No such file or directory, uninstall dbt and reinstall.
```
$ pip3 uninstall dbt-core
$ pip3 install --user --upgrade dbt-bigquery
```

If you have issues with versioning when you try to run dbt then run
```
~/.local/bin/dbt run --no-version-check
```

If you get ERROR: gcloud failed to load: No module named '_sqlite3' because you use python with adf try running
```
export CLOUDSDK_PYTHON=/usr/bin/python3
```