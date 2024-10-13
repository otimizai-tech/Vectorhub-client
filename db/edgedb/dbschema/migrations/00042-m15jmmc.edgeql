CREATE MIGRATION m15jmmcgu5dpwxhxzqwbgsbrznfzksqxwtesn3osbh5m4hpijoeqqq
    ONTO m1bhh7noegaawlnc2kqdofrxe55cfd2srt3rcmf6blgxz5xvxfd2la
{
  ALTER TYPE default::Folder {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection)
          SET {
              folders += __new__
          });
  };
};
