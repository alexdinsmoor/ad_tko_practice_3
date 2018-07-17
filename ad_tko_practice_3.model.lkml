connection: "thelook_events"

include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

explore: order_items{
  description: "Order item information"
}

explore: user_facts {}
