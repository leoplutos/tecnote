use sea_orm::entity::prelude::*;

// sea-orm 的 Entity
#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq)]
#[sea_orm(table_name = "t_employee", schema_name = "public")]
pub struct Model {
    #[sea_orm(primary_key)]
    #[sea_orm(column_name = "te_pk")]
    pub te_pk: Uuid,
    #[sea_orm(column_name = "employee_id")]
    pub employee_id: String,
    #[sea_orm(column_name = "employe_name")]
    pub employe_name: Option<String>,
    #[sea_orm(column_name = "employe_email")]
    pub employe_email: Option<String>,
    #[sea_orm(column_name = "employe_status")]
    pub employe_status: Option<i16>,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
