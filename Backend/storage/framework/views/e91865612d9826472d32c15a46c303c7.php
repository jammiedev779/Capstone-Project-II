<div
    <?php echo e($attributes
            ->merge([
                'id' => $getId(),
            ], escape: false)
            ->merge($getExtraAttributes(), escape: false)); ?>

>
    <?php echo e($getChildComponentContainer()); ?>

</div>
<?php /**PATH C:\Users\johnk\Capstone-Project-II\Backend\vendor\filament\forms\resources\views\components\group.blade.php ENDPATH**/ ?>