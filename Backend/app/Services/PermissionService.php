<?php
namespace App\Services;

class PermissionService {
    public static function returnMethod($panel){
        return ['viewAny '.$panel,
                'view '.$panel,
                'create '.$panel,
                'update '.$panel,
                'delete '.$panel,
                'restore '.$panel,
                'forceDelete '.$panel,
                ];
    }
}
?>