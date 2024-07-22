<?php
    $id = $getId();
    $isContained = $getContainer()->getParentComponent()->isContained();

    $activeTabClasses = \Illuminate\Support\Arr::toCssClasses([
        'fi-active',
        'p-6' => $isContained,
        'mt-6' => ! $isContained,
    ]);

    $inactiveTabClasses = 'absolute h-0 overflow-hidden p-0';
?>

<div
    x-bind:class="{
        <?php echo \Illuminate\Support\Js::from($activeTabClasses)->toHtml() ?>: tab === <?php echo \Illuminate\Support\Js::from($id)->toHtml() ?>,
        <?php echo \Illuminate\Support\Js::from($inactiveTabClasses)->toHtml() ?>: tab !== <?php echo \Illuminate\Support\Js::from($id)->toHtml() ?>,
    }"
    x-on:expand="tab = <?php echo \Illuminate\Support\Js::from($id)->toHtml() ?>"
    <?php echo e($attributes
            ->merge([
                'aria-labelledby' => $id,
                'id' => $id,
                'role' => 'tabpanel',
                'tabindex' => '0',
                'wire:key' => "{$this->getId()}.{$getStatePath()}." . \Filament\Forms\Components\Tabs\Tab::class . ".tabs.{$id}",
            ], escape: false)
            ->merge($getExtraAttributes(), escape: false)
            ->class(['fi-fo-tabs-tab outline-none'])); ?>

>
    <?php echo e($getChildComponentContainer()); ?>

</div>
<?php /**PATH C:\Users\vinun\Desktop\Term 7\Capstone-Project-II\Backend\vendor\filament\forms\src\/../resources/views/components/tabs/tab.blade.php ENDPATH**/ ?>