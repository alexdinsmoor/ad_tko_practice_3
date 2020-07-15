connection: "snowlooker"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

## DATAGROUPS ##

datagroup: daily_caching_policy {
  sql_trigger: select current_date ;;
  max_cache_age: "24 hours"
}

## EXPLORES ##








## HIDDEN EXPLORES ##

# explore: order_items {

#   label: "0) Storj Example"

#   join: users {
#     type: left_outer
#     sql_on: ${order_items.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }

#   join: node_rolling_facts {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${order_items.created_date} = ${node_rolling_facts.created_date} ;;
#   }

# }

explore: word_frequency_facts {
  hidden:yes
}
