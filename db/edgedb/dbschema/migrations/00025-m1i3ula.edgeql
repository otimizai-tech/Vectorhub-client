CREATE MIGRATION m1i3ulast4kn2vdel72qmwhkbqluhgvwd2vb3yvjltx7fotmvm7dua
    ONTO m1ac242we2h6a2hdssix5mnbtskxrefgi46vkyezisj7kne6hteenq
{
  ALTER TYPE default::Tag {
      ALTER LINK X_ref {
          RENAME TO chunks;
      };
  };
};
