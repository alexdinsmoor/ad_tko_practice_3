view: user_order_facts {
  derived_table: {
    sql: select user_id
        , min(created_at) as first_order
        , count(distinct order_id) as lifetime_orders
        , sum(sale_price) as lifetime_revenue
      from order_items
      group by 1
       ;;
      datagroup_trigger: daily_caching_policy
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: first_order {
    type: time
    sql: ${TABLE}.first_order ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  measure: average_lifetime_revenue {
    type: average
    sql: ${lifetime_revenue} ;;
    value_format_name: usd_0
  }

  set: detail {
    fields: [user_id, first_order_time, lifetime_orders, lifetime_revenue]
  }
}
