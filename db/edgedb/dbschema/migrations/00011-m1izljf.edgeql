CREATE MIGRATION m1izljfzeawvsjgambolbleb23tlejza2o46krbfghdwinmdh2n72q
    ONTO m1kc6ahxfvxrdgw3awwpjrfi4pvu2aslfmcf3d4l4e5giskho2vzpq
{
  ALTER TYPE default::DataBaseHub {
      ALTER ACCESS POLICY acess_collection_s USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<databases[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<databases[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_u USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<databases[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<databases[IS default::Collection].name))));
  };
};
