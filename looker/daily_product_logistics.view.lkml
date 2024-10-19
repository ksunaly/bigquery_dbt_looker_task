view: daily_product_logistics {
  # Dynamically use the schema based on the user's environment attribute
  sql_table_name: 
    {% if _user_attributes['environment'] == 'prod' %}
      `{{_user_attributes['dbt_schema']}}.daily_product_logistics`
    {% else %}
      `{{_user_attributes['sandbox_schema']}}.daily_product_logistics`
    {% endif %} ;;

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    description: "Unique identifier for the product." #add description
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
    description: "The name of the product."
  }

  dimension: product_category {
    sql: ${TABLE}.product_category ;;
    description: "The category the product belongs to."
  }

  dimension: product_subcategory {
    sql: ${TABLE}.product_subcategory ;;
    description: "A more specific classification within the product category."
  }

  dimension_group: date_day {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_day ;;
    description: "The day when the logistics event was recorded."
  }

  measure: average_days_to_pack {
    type: average
    sql: ${avg_days_to_pack} ;;
    description: "The average number of days it took to pack the product."
  }

  measure: average_days_to_ship {
    type: average
    sql: ${avg_days_to_ship} ;;
    description: "The average number of days it took to ship the product after it was packed."
  }

  measure: average_days_to_deliver {
    type: average
    sql: ${avg_days_to_deliver} ;;
    description: "The average number of days it took to deliver the product after it was shipped."
  }

  measure: average_days_to_pack_us_customers {
    type: average
    sql: ${avg_us_days_to_pack} ;;
    description: "The average number of days it took to pack orders for US customers."
  }

  measure: average_days_to_ship_us_customers {
    type: average
    sql: ${avg_us_days_to_ship} ;;
    description: "The average number of days it took to ship orders to US customers."
  }

  measure: average_days_to_deliver_us_customers {
    type: average
    sql: ${avg_us_days_to_deliver} ;;
    description: "The average number of days it took to deliver orders to US customers."
  }

  measure: average_days_to_pack_contractor_customers {
    type: average
    sql: ${avg_contractor_days_to_pack} ;;
    description: "The average number of days it took for contractors to pack orders."
  }

  measure: average_days_to_ship_contractor_customers {
    type: average
    sql: ${avg_contractor_days_to_ship} ;;
    description: "The average number of days it took for contractors to ship orders."
  }

  measure: average_days_to_deliver_contractor_customers {
    type: average
    sql: ${avg_contractor_days_to_deliver} ;;
    description: "The average number of days it took for contractors to deliver orders."
  }
}
