view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  measure: first_order_date  {
    type: date
    sql: MIN(${created_raw}) ;;
  }

  measure: months_since_first_order {
    type: number
    sql: DATEDIFF('months', ${first_order_date}, current_date) ;;

  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    label: "Company A Definition"
    type: count
    drill_fields: [detail*]
  }

  #financial measures
  measure: total_sale_price {
    type: sum
    sql:${sale_price};;
    value_format_name: usd_0
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure:  gross_margin {
    description: "Sale price minus item cost"
    type: number
    sql:  ${sale_price} - ${inventory_items.cost} ;;
    value_format_name: usd_0
  }

  measure:  total_gross_margin {
    description: "Total sale price minus total cost"
    type: number
    sql:  ${total_sale_price} - ${inventory_items.total_cost} ;;
    value_format_name: usd_0
  }

  # test pivot and dynamic field labels use case

  dimension: column1 {
    type: string
    sql: 'column1' ;;
  }

  dimension: column1_join_key {
    type: string
    sql: right(${column1},1) ;;
  }

  dimension: column2 {
    type: string
    sql: 'column2' ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.id,
      inventory_items.product_name,
      users.id,
      users.last_name,
      users.first_name
    ]
  }
}
