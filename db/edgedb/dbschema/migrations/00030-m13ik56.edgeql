CREATE MIGRATION m13ik56zcot5x2xi56dzpanisdqtdsiolrvvse6t3ymobcojchxaka
    ONTO m1vkfgpwvn6pn2as3edo7u4mausnxnyayq675kzp5wihtdkr7qmg4a
{
  ALTER TYPE default::Chunk {
      CREATE PROPERTY contentType: std::str;
  };
  ALTER TYPE default::DataBaseHub {
      CREATE PROPERTY contentType: std::str;
  };
  ALTER TYPE default::File {
      CREATE PROPERTY fileID: std::str;
  };
};
