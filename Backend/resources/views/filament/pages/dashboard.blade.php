<x-filament-panels::page>
    @push('styles')
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    @endpush
    <div>
        @include('components.statistic_card')
    </div>
    <div class="grid md:grid-cols-1 xl:grid-cols-1">
        @include('components.line_chart')
    </div>
        <div class="grid md:grid-cols-1 xl:grid-cols-1">
        @include('components.bar_chart')
    </div>
    <div class="grid md:grid-cols-1 xl:grid-cols-1">
        @include('components.pie_chart')
    </div>
</x-filament-panels::page>

    <script>
        function getMonths() {
            const months = [];
            const date = new Date();

            for (let i = 0; i < 12; i++) {
                date.setMonth(i);
                months.push(date.toLocaleString('default', {
                    month: 'short'
                }));
            }

            return months;
        }
        const months = getMonths();
    </script>
