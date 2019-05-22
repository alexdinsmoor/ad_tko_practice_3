view: order_items {
  sql_table_name: PUBLIC.ORDER_ITEMS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
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
    sql: ${TABLE}."CREATED_AT" ;;
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
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
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
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
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
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  ## measures

  measure: total_sales {
    label: "Total Revenue"
    description: "Total revenue from user trades"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: total_sales_cancelled {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
    filters: {
      field: status
      value: "Cancelled"
    }
  }

  measure: percentage_of_sales_cancelled {
    type: number
    sql: 1.0*${total_sales_cancelled} / nullif(${total_sales}, 0) ;;
    value_format_name: percent_1
  }


  measure: count {
    type: count
    drill_fields: [drill_set*]
  }

  set: drill_set {
    fields: [id, users.id, users.first_name, users.last_name]
  }


}
