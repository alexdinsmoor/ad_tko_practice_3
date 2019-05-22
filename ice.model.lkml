connection: "snowlooker"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

datagroup: daily_caching_policy  {
  max_cache_age: "24 hours"
  sql_trigger: select current_date ;;
}

persist_with: daily_caching_policy

explore: order_items {
  persist_with: daily_caching_policy
  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }
  join: user_order_facts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${user_order_facts.user_id} ;;
  }
}
