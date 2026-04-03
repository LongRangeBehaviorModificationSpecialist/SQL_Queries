/*
[DLU]
    2024-10-21
[DATABASE PATH]
    /private/var/mobile/Library/Accounts/Accounts3.sqlite
*/

SELECT

    ROW_NUMBER() OVER() AS 'row_number',
    datetime('2001-01-01', zaccount.zdate || ' seconds') AS 'account_date',

    datetime('2001-01-01', zaccount.ZLASTCREDENTIALRENEWALREJECTIONDATE || ' seconds') AS 'renewal_rejection',
    ZACCOUNTTYPE.ZACCOUNTTYPEDESCRIPTION AS 'account_type_description',
    ZACCOUNTTYPE.ZIDENTIFIER AS 'account_identifier',
    zaccount.ZUSERNAME AS 'Username',
    zaccount.ZACCOUNTDESCRIPTION AS 'account_description',

    CASE zaccount.ZACTIVE
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
    END AS 'account_active',

    CASE zaccount.ZAUTHENTICATED
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
    END AS 'account_authenticated',

    CASE zaccount.ZSUPPORTSAUTHENTICATION
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
    END AS 'account_supports_auth',

    zaccount.ZAUTHENTICATIONTYPE AS 'authentication_type',
    ZACCOUNTTYPE.ZCREDENTIALTYPE AS 'credential_type',
    ZACCOUNTPROPERTY.ZKEY AS 'key',

    CASE zaccount.ZVISIBLE
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
    END AS 'account_visible',

    zaccount.ZIDENTIFIER AS 'identifier',
    zaccount.ZOWNINGBUNDLEID AS 'owning_bundle_id'

    /* Source for each line of data */
    --TODO -> confirm primary keys for the zaccount and zaccounttype tables and enter values below
    'Accounts3.sqlite; Table:zaccount(Z_PK:' || ZLIVEUSAGE.Z_PK || '), ' || 'Table: ZACCOUNTTYPE(Z_PK:' || ZPROCESS.Z_PK || ')' AS 'data_source'


FROM zaccount
    JOIN ZACCOUNTTYPE ON ZACCOUNTTYPE.Z_PK = zaccount.ZACCOUNTTYPE
    JOIN ZACCOUNTPROPERTY ON ZACCOUNTPROPERTY.Z_PK = zaccount.Z_OPT


ORDER BY zaccount.zdate DESC