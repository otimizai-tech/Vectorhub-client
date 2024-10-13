CREATE MIGRATION m15tiwtvvt73irfhj2yqrca7yazh5mclzhdhkawzdhdvr4kybpanha
    ONTO m1y5psnrbdpdovi2eimw64pvlvk3luix4gvx4l4hcp6mquqelsamfa
{
  ALTER TYPE default::Dashbord {
      ALTER PROPERTY description {
          SET default := 'Dashboard';
      };
      ALTER PROPERTY name {
          SET default := 'Dashboard';
      };
  };
  ALTER TYPE default::DataBaseHub {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection)
          SET {
              databases += __new__
          });
  };
};
