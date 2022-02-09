connection: "dinsmoor-bigquery"

include: "*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.

explore: mobile_data_2015_2017 {
  group_label: "0) Mobility"
  label: "Mobility Details"
}


explore: mobility_facts {}

datagroup: hourly {
  sql_trigger: select extract(hour from current_timestamp)  ;;
}
