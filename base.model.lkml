connection: "thelook_events"

include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

# label: "Extend Example"

explore: order_items {
  hidden: yes
  view_name: order_items
  from: order_items
  description: "Order item information"

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

# explore: order_items_extend {
#   extends: [order_items]
#   label: "Order Items Extended"
#
#   # sql_always_where: ${products.brand} = '{{_user_attributes["brand"] }}' ;;
#
#   fields: [ALL_FIELDS*,
#           - order_items.total_sale_price,
#           - order_items.average_sale_price,
#           - order_items.total_gross_margin
#           ]
# }
