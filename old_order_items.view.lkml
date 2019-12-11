view: order_items_1 {
  sql_table_name: PUBLIC.ORDER_ITEMS ;;
  drill_fields: [id]

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

  dimension: is_offline {
    type: yesno
    sql: ${status} = 'Cancelled' ;;
  }

  ## measures

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id]
  }

  measure: total_nodes_offline {
    description: "Offline status indicates node is down"
    type: count_distinct
    sql: ${id} ;;
    value_format_name: decimal_0
    drill_fields: [drill_details*]
    filters: {
      field: is_offline
      value: "yes"
    }
  }

  measure: total_churn_percentage {
    type: number
    sql: 1.0*${total_nodes_offline} / nullif(${count},0) ;;
    value_format_name: percent_1
    drill_fields: [drill_details*]
  }

  set: drill_details {
    fields: [id, users.last_name, users.first_name, users.id]
  }


}
