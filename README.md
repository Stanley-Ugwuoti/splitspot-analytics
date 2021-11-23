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


on new cmd run 
```
 cd $HOME && nano .dbt/profiles.yml
```
Then paste the contents of profile.yml file into the newly created .dbt/profile.yml

Then install gcloud following the instructions here https://cloud.google.com/sdk/docs/install

Then run
```
gcloud auth application-default login
```
A window will open in the browser where you'll login and copy a code sent to you and paste in the commandline.