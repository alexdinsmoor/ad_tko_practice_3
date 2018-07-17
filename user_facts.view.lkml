view: user_facts {
  derived_table: {
    sql: SELECT user_id, first_name, last_name, latitude, longitude, MIN(oi.created_at) as first_order_date, MAX(oi.created_at) as last_order_date,
      avg(sale_price) as avg_sale_price,
      sum(sale_price) as lifetime_value, count(distinct order_id) as lifetime_orders
      FROM public.order_items as oi
      LEFT JOIN public.users as u on oi.user_id = u.id
      group by 1,2,3,4,5
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension_group: first_order_date {
    type: time
    sql: ${TABLE}.first_order_date ;;
  }

  dimension_group: last_order_date {
    type: time
    sql: ${TABLE}.last_order_date ;;
  }

  dimension: user_level_avg_sale_price {
    type: number
    sql: ${TABLE}.avg_sale_price ;;
  }

  dimension: lifetime_value {
    type: number
    sql: ${TABLE}.lifetime_value ;;
  }

  dimension: lifetime_value_tier {
    type: tier
    tiers: [0,250,500,750,1000,1250,1500,1750,2000]
    style: integer
    sql: ${lifetime_value};;
  }

  measure: avg_lifetime_value {
    type: average
    value_format_name: usd
    sql: ${lifetime_value} ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  set: detail {
    fields: [
      user_id,
      first_name,
      last_name,
      latitude,
      longitude,
      first_order_date_time,
      last_order_date_time,
      lifetime_value,
      lifetime_orders,
      location
    ]
  }
}
