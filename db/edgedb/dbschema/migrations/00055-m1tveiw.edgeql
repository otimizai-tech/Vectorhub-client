CREATE MIGRATION m1tveiw4xo3rxqx7bnta4aknovykcp43hyhz2lc65ffdrrzgfmfs2q
    ONTO m1umzgatmmi52f75ocsfteisyxl7zksqeojvvvtj5s2l2hr6wkzhpa
{
  ALTER TYPE default::Collection {
      ALTER LINK dashbord {
          ON TARGET DELETE ALLOW;
      };
  };
};
