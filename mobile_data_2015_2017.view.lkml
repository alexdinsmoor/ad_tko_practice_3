view: mobile_data_2015_2017 {
  sql_table_name: `dinsmoor.mobility.mobile_data_2015_2017`
    ;;

  dimension: activity {
    type: string
    sql: ${TABLE}.activity ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

#   dimension: days_to_roll_forward {
#     type: number
#     sql_start: date_diff('2017-12-31',current_date,day) ;;
#   }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: download_speed {
    type: number
    sql: ${TABLE}.downloadSpeed ;;
  }

  dimension_group: hour {
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
    sql: ${TABLE}.hour ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: long {
    type: number
    sql: ${TABLE}.long ;;
  }

  dimension: net {
    type: string
    sql: ${TABLE}.net ;;
  }

  dimension: network {
    type: string
    sql: ${TABLE}.network ;;
  }

  dimension: operator {
    type: string
    sql: ${TABLE}.operator ;;
  }

  dimension: position_geom {
    type: string
    sql: ${TABLE}.position_geom ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }

  dimension: precission {
    type: number
    sql: ${TABLE}.precission ;;
  }

  dimension: provider {
    type: string
    sql: ${TABLE}.provider ;;
  }

  dimension: satellites {
    type: number
    sql: ${TABLE}.satellites ;;
  }

  dimension: signal {
    type: number
    sql: ${TABLE}.signal ;;
  }

  dimension: speed {
    type: number
    sql: ${TABLE}.speed ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: town_name {
    type: string
    sql: ${TABLE}.town_name ;;
  }

  dimension: upload_speed {
    type: number
    sql: ${TABLE}.uploadSpeed ;;
  }

  ## measures

  measure: average_signal {
    type: average
    sql: ${signal} ;;
  }

  measure: count {
    type: count
    drill_fields: [town_name]
  }
}
