connection: "thelook_events"

include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

explore: order_items {
  hidden: yes
  view_name: order_items
  from: order_items
  description: "Order item information"

  sql_always_where: ${products.brand} like '%{{_user_attributes["brand"] }}%' ;;

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}
