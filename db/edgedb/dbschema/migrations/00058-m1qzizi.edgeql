CREATE MIGRATION m1qzizif3xiplsiw22sv435gsn4eo6lh4xncsvhlflwwoz7ofiasha
    ONTO m1b674fras7vot54ppp7wllepmfzbmvdiiy4od4imzt2eceaq2qcna
{
  ALTER TYPE default::File {
      CREATE TRIGGER update_is_enable_chunks
          AFTER UPDATE 
          FOR EACH 
              WHEN ((__new__.isEnabled != __old__.isEnabled))
          DO (UPDATE
              __old__.chunks
          SET {
              isEnabled := __new__.isEnabled
          });
  };
  ALTER TYPE default::Folder {
      CREATE TRIGGER update_is_enable_files
          AFTER UPDATE 
          FOR EACH 
              WHEN ((__new__.isEnabled != __old__.isEnabled))
          DO (UPDATE
              __old__.files
          SET {
              isEnabled := __new__.isEnabled
          });
  };
};
