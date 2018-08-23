include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

include: "base.model.lkml"

label: "Extend Example"

explore: order_items_extend_company_A {
  hidden: no
  extends: [order_items]
  label: "Order Items Extended for Company A"

  # sql_always_where: ${products.brand} = '{{_user_attributes["brand"] }}' ;;

  fields: [ALL_FIELDS*,
    - order_items.total_sale_price,
    - order_items.average_sale_price,
    - order_items.total_gross_margin
  ]

  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }
}
