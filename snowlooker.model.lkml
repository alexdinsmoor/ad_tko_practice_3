connection: "snowlooker"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

datagroup: daily_caching_policy {
  sql_trigger: select current_date ;;
  max_cache_age: "24 hours"
}


explore: word_frequency_facts {}
