CREATE MIGRATION m1ts6n3am4pkdyaivexenz5yoqdfypprwn6ocsa7adfrymzhymvkfa
    ONTO m15jmmcgu5dpwxhxzqwbgsbrznfzksqxwtesn3osbh5m4hpijoeqqq
{
  ALTER TYPE default::Chunk {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection)
          SET {
              chunks += __new__
          });
  };
};
