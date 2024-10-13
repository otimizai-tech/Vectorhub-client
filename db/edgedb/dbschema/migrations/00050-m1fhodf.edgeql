CREATE MIGRATION m1fhodfklmabl7jy5g5mlkzaz67c65hfkqkx465z5ruodbun73slsq
    ONTO m15tiwtvvt73irfhj2yqrca7yazh5mclzhdhkawzdhdvr4kybpanha
{
  ALTER TYPE default::Dashbord {
      ALTER PROPERTY name {
          SET default := 'dashboard';
      };
  };
  ALTER TYPE default::DataBaseHub {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING ((GLOBAL default::current_collection ?= std::assert_single(.<databases[IS default::Collection].id)));
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING ((GLOBAL default::current_collection ?= std::assert_single(.<databases[IS default::Collection].id)));
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING ((GLOBAL default::current_collection ?= std::assert_single(.<databases[IS default::Collection].id)));
  };
};
