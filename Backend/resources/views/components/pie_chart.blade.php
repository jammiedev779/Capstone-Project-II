<div id="pie_chart">
</div>

@push('scripts')
    <script>
        var options = {
            chart: {
                height: 350,
                type: "donut",
            },
            series: [44, 55, 13, 33],
            labels: ['Apple', 'Mango', 'Orange', 'Watermelon']
        };

        var chart = new ApexCharts(document.querySelector("#pie_chart"), options);

        chart.render();
    </script>
@endpush
