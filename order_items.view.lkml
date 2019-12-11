view: order_items {
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

  dimension: new_sale_price {
    description: "Saving time, saving lives"
    type: number
    sql: ${sale_price} / 100.0 ;;
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

  dimension: is_cancelled {
    type: yesno
    sql: ${status} = 'Cancelled' ;;
  }

  ## measures

  measure: total_cancelled_jobs {
    description: "Job status of cancelled before appointment date"
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: is_cancelled
      value: "yes"
    }
  }

  measure: count {
    type: count
    drill_fields: [details*]
  }

  measure: cancellation_rate {
    type: number
    sql: 1.0*${total_cancelled_jobs} / nullif(${count},0) ;;
    value_format_name: percent_1
    drill_fields: [details*]
  }

  ## drill fields

  set: details {
    fields: [id, users.first_name, users.last_name, users.id, created_date, sale_price]
  }

}
